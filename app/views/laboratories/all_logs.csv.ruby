require "csv"
require "nkf"

today = Date.current
range = today.beginning_of_financial_year-1.month..today.end_of_financial_year-1.month

csvs = CSV.generate do |csv|
  csv << ["開始日時", "終了日時", "ステータス", "時間[m]", "メンバー"]

  @lab.members.each do |member|
    logs = member.all_logs_at_range(range, Member.statuses.values)

    logs.each do |log|
      csv << [log.created_at-log.total_time, log.created_at, log.status_i18n, (log.total_time/60.0).round(1), member.lastname+member.firstname]
    end
  end
end

NKF.nkf("--sjis -Lw", csvs)