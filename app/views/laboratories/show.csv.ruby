require "csv"
require "nkf"

today = Date.current

csvs = CSV.generate do |csv|
  csv << ["名前", @member.lastname+@member.firstname]
  csv << ["期間", @period]
  csv << ["日付", "八束穂[h]", "在宅[h]", "扇が丘[h]", "食事[h]", "授業[h]", "学外[h]"]
  
  @period.each do |date|
    column = []
    column << date.strftime('%Y/%m/%d(%a)')
    column << @member.each_logs_at_range(date.beginning_of_day..date.end_of_day, 0..1)
    (2..6).each do |num|
      column << @member.each_logs_at_range(date.beginning_of_day..date.end_of_day, num)
    end
    csv << column
  end
end

NKF.nkf("--sjis -Lw", csvs)
