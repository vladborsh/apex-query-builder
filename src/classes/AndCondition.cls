public class AndCondition implements Condition  {

  List<Condition> conditions;

  public AndCondition( Condition conditionOne, Condition conditionTwo ) {
    conditions = new List<Condition>();
    conditions.add( conditionOne );
    conditions.add( conditionTwo );
  }

  public AndCondition( List<Condition> conditions ) {
    conditions = new List<Condition>( conditions );
  }

  public String getClauseString() {
    String clause = '';
    Integer i = 0;
    for( Condition conditionItem : conditions ) {
      clause += '(' + conditionItem.getClauseString() + ')';
      if ( i++ != conditions.size() - 1 ) {
        clause += ' AND ';
      }
    }
    return clause;
  }

}