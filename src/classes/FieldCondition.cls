public class FieldCondition implements Condition  {

  String fieldName;
  String operator;
  Object fieldValue;

	public FieldCondition( String fieldName ) {
		this.fieldName = fieldName;
	}

  public FieldCondition equals( Object value ) {
    this.operator = '=';
    this.fieldValue = value;
    return this;
  }

  public FieldCondition equalsNull() {
    this.operator = '=';
    this.fieldValue = null;
    return this;
  }

  public FieldCondition notEquals( Object value ) {
    this.operator = '!=';
    this.fieldValue = value;
    return this;
  }

  public FieldCondition notEqualsNull() {
    this.operator = '!=';
    this.fieldValue = null;
    return this;
  }

  public FieldCondition lessThan( Object value ) {
    this.operator = '<';
    this.fieldValue = value;
    return this;
  }

  public FieldCondition moreThan( Object value ) {
    this.operator = '>';
    this.fieldValue = value;
    return this;
  }

  public FieldCondition isIn( Set<String> valueSet ) {
    this.operator = 'IN';
    this.fieldValue = valueSet;
    return this;
  }

  public String getClauseString() {
    if ( fieldValue instanceof String ) {
      return fieldName + ' ' + operator + ' \'' + String.valueOf( fieldValue ) + '\'';
    } else if ( fieldValue instanceof Set<String> ) {
      return fieldName + ' ' + operator + ' (' + getValuesString( (Set<String>)fieldValue ) + ')';
    } else {
      return fieldName + ' ' + operator + ' ' + String.valueOf( fieldValue );
    }
  }

  private static String getValuesString( Set<String> valueSet ) {
    String result = '';
    Integer i = 0;
    for ( String fieldValue : valueSet ) {
      result += '\'' + fieldValue + '\'';
      if ( i++ != valueSet.size() - 1) {
        result += ',';
      }
    }
    return result;
  }

}