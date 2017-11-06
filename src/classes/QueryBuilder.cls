public with sharing class QueryBuilder {

  List<Object> selections;
  String source;
  Condition conditionRoot;
  Integer limitValue;
  String orderByFieldName;
  Integer offsetValue;

	public QueryBuilder() {
		this.selections = new List<Object>();
	}

  public QueryBuilder setSelect( List<Object> fields ) {
    List<Object> filtredList = new List<Object>();
    for ( Object field : fields ) {
      for ( Object selectedItem : this.selections ) {
        if (
          !( 
            ( 
                 selectedItem instanceof String 
              && field instanceof String
              && ((String)selectedItem).equals((String)field)
            ) 
              ||
            (
                 selectedItem instanceof QueryBuilder 
              && field instanceof QueryBuilder
              && ((QueryBuilder)selectedItem).getFrom().equals( ((QueryBuilder)field).getFrom() )
            )
          )
        ) {
          filtredList.add(field);
        }
      }
    }
    this.selections.add( filtredList );
    return this;
  }

  public QueryBuilder setSelect( String field ) {
    List<Object> filtredList = new List<Object>();
    for ( Object selectedItem : this.selections ) {
      if ( 
        !( 
             ( selectedItem instanceof String )
          && ((String)selectedItem ).equals( field ) 
        )
      ) {
        filtredList.add(field);
      }
    }
    this.selections.add( filtredList );
    return this;
  }


  public QueryBuilder setSelect( AggregateFunction function ) {
    List<Object> filtredList = new List<Object>();
    for ( Object selectedItem : this.selections ) {
      if ( 
        !( 
             ( selectedItem instanceof String )
          && ((String)selectedItem ).equals( function.fieldName ) 
        )
      ) {
        filtredList.add(function);
      }
    }
    this.selections.add( filtredList );
    return this;
  }

  public QueryBuilder setSelect( QueryBuilder builderItem ) {
    List<Object> filtredList = new List<Object>();
    for ( Object selectedItem : this.selections ) {
      if ( 
        !( 
             ( selectedItem instanceof QueryBuilder )
          && ((QueryBuilder)selectedItem).getFrom().equals( (builderItem).getFrom() )
        )
      ) {
        filtredList.add(builderItem);
      }
    }
    this.selections.add( filtredList );
    return this;
  }

  public QueryBuilder setFrom( String source ) {
    this.source = source;
    return this;
  }

  public String getFrom() {
    return this.source;
  }

  public QueryBuilder setWhereClause( Condition condition ) {
    if ( conditionRoot == null ) {
      conditionRoot = condition;
    } 
    return this;
  }

  public Condition getClause() {
    return this.conditionRoot;
  }

  public QueryBuilder setLimit( Integer limitValue ) {
    this.limitValue = limitValue;
    return this;
  }

  public Integer getLimit() {
    return this.limitValue;
  }

  public QueryBuilder setOrderBy( String fieldName ) {
    this.orderByFieldName = fieldName;
    return this;
  }

  public String getOrderBy() {
    return this.orderByFieldName;
  }

  public QueryBuilder setOffset( Integer offsetValue ) {
    this.offsetValue = offsetValue;
    return this;
  }


  public List<SObject> execute() {
    return Database.query(this.getSoql());
  }

  public String getSoql() {
    if (this.source == null) 
      throw new QueryBuilderException('Source SObject not provided');
    String result = 'SELECT Id';
    result += getSelectedItemsAsString();
    result += ' FROM ' + source;
    if ( this.conditionRoot != null )
      result += ' WHERE ' + this.conditionRoot.getClauseString();
    if ( this.limitValue != null ) {
      result += ' LIMIT ' + this.limitValue;
    }
    return result;
  }

  private String getSelectedItemsAsString() {
    if (this.selections.size() == 0) {
      return '';
    }
    String result = '';
    for ( Object selectedItem : this.selections ) {
      if ( selectedItem instanceof String ) {
        result += ',' + (String)selectedItem;
      }
      if ( selectedItem instanceof QueryBuilder ) {
        result += ',(' + ((QueryBuilder)selectedItem).getSoql() + ')';
      }
      if ( selectedItem instanceof AggregateFunction ) {
        result += ',' + ((AggregateFunction)selectedItem).toString();
      }
    }
    return result;
  }


}