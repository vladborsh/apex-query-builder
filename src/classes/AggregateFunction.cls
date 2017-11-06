public with sharing class AggregateFunction {

  public String fieldName;
  public String functionName;

  public AggregateFunction( String fieldName ) {
    this.fieldName = fieldName;
  }


  public AggregateFunction() {
  }

  public AggregateFunction setAvg() {
    this.functionName = 'AVG';
    return this;
  }

  public AggregateFunction setCount() {
    this.functionName = 'COUNT';
    return this;
  }

  public AggregateFunction setCountDistinct() {
    this.functionName = 'COUNT_DISTINCT';
    return this;
  }

  public AggregateFunction setMin() {
    this.functionName = 'MIN';
    return this;
  }

  public AggregateFunction setMax() {
    this.functionName = 'MAX';
    return this;
  }

  public AggregateFunction setSum() {
    this.functionName = 'SUM';
    return this;
  }

  public String getFieldName() {
    return this.fieldName;
  }

  public override String toString() {
    return this.functionName + '(' + this.fieldName + ')';
  }


}