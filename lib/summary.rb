class Summary
  def self.build_and_save(options = {})
    query = self.build_query(options)
    final_result = ActiveRecord::Base.connection.execute query
    final_result_hash(final_result)
  end

  def self.build_query(options)
    # Query for grouping by week.
    # We can make more efficient by storing workflow_state
    # as integer rather than string.
    start_date = options[:start_date]
    all_records = options[:all_records] || false
    query_middle = ""
    query_head =  "SELECT date(updated_at, 'weekday 0', '-6 days') || '-' || date(updated_at, 'weekday 0') as week_range, "\
                  "updated_at as week_start, "\
                  "date(updated_at, 'weekday 0') as week_end, "\
                  "count(CASE WHEN workflow_state='applied' THEN 1 END) as applied, "\
                  "count(CASE WHEN workflow_state='quiz_started' THEN 1 END) as quiz_started, "\
                  "count(CASE WHEN workflow_state='quiz_completed' THEN 1 END) as quiz_completed, "\
                  "count(CASE WHEN workflow_state='onboarding_requested' THEN 1 END) as onboarding_requested, "\
                  "count(CASE WHEN workflow_state='onboarding_completed' THEN 1 END) as onboarding_completed, "\
                  "count(CASE WHEN workflow_state='hired' THEN 1 END) as hired, "\
                  "count(CASE WHEN workflow_state='rejected' THEN 1 END) as rejected "\
                  "FROM applicants "\

    unless all_records
      query_middle = "WHERE updated_at >= date('#{start_date}') "\
    end
    query_tail = "GROUP by strftime('%W', updated_at)"
    query_head + query_middle + query_tail
  end

  def self.final_result_hash(results)
    final_result = {}
    results.each do |week|
      final_result[week["week_range"]] = {
        "applied" => week["applied"],
        "quiz_started" => week["quiz_started"],
        "quiz_completed" => week["quiz_completed"],
        "onboarding_requested" => week["onboarding_requested"],
        "onboarding_completed" => week["onboarding_completed"],
        "hired" => week["hired"],
        "rejected" => week["rejected"],
        "week_start" => week["week_start"],
        "week_end" => week["week_end"]
      }
    end
    final_result
  end
end