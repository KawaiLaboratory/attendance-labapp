require "csv"
require "nkf"

today = Date.current

csv = CSV.generate do |csv|
  csv << ["名前", @member.lastname+@member.firstname]
  csv << ["#{today.financial_year}年度の活動時間[h]", (@member.active_logs_at_day(today.beginning_of_financial_year..today.end_of_financial_year).sum(:total_time)/3600.0).round(1)]
  csv << ["期間", @period]
  csv << ["日付", "八束穂[h]", "扇が丘[h]", "食事[h]", "授業[h]", "学外[h]"]
  
  @period.each do |date|
    column = []
    column << date.strftime('%Y/%m/%d(%a)')
    column << (@member.each_logs_at_day(date.beginning_of_day..date.end_of_day, 0..2).sum(:total_time)/3600.0).round(1)
    (3..6).each do |num|
      column << (@member.each_logs_at_day(date.beginning_of_day..date.end_of_day, num).sum(:total_time)/3600.0).round(1)
    end
    csv << column
  end
end

NKF.nkf("--sjis -Lw", csv)
