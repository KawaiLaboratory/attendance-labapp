require "csv"
require "nkf"

csv = CSV.generate do |csv|
  csv << ["名前", @member.lastname+@member.firstname]
  csv << ["期間", @period]
  csv << ["日付[h]", "八束穂[h]", "扇が丘[h]", "食事[h]", "授業[h]", "学外[h]"]
  
  @period.each do |date|
    column = []
    column << date
    column << (@member.each_logs_at_day(date.beginning_of_day..date.end_of_day, 0..2).sum(:total_time)/3600.0).round(1)
    (3..6).each do |num|
      column << (@member.each_logs_at_day(date.beginning_of_day..date.end_of_day, num).sum(:total_time)/3600.0).round(1)
    end
    csv << column
  end
end

NKF.nkf("--sjis -Lw", csv)
