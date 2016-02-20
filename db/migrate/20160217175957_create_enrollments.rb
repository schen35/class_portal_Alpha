class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :instructor_id
      t.integer :course_id
      t.float :grade
      t.text :material
      t.boolean :admission

      t.timestamps null: false
    end

    add_index :enrollments, :student_id
    add_index :enrollments, :instructor_id
    add_index :enrollments, :course_id
  end
end
