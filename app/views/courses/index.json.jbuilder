json.array!(@courses) do |course|
  json.extract! course, :id, :Course_num, :Title, :Description, :Instructor, :Start_date, :End_date, :Status
  json.url course_url(course, format: :json)
end
