json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :student_id, :instructor_id, :course_id, :grade, :material, :admission
  json.url enrollment_url(enrollment, format: :json)
end
