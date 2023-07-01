class StudentsController < ApplicationController
    def index
      students = Student.all
      render json: students, status: :ok
    end
  
    def show
      student = Student.find_by(id: params[:id])
      if student.nil?
        render json: { errors: "Student not found" }, status: :not_found
      else
        render json: student, status: :ok
      end
    end
  
    def create
      student = Student.new(student_params)
      if student.save
        render json: student, status: :created
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      student = Student.find_by(id: params[:id])
      if student.nil?
        render json: { errors: "Student not found" }, status: :not_found
      elsif student.update(student_params)
        render json: student, status: :ok
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      student = Student.find_by(id: params[:id])
      if student.nil?
        render json: { errors: "Student not found" }, status: :not_found
      elsif student.destroy
        head :no_content, status: :ok
      else
        render json: { errors: "Failed to delete student" }, status: :unprocessable_entity
      end
    end
  
    private
  
    def student_params
      params.permit(:name, :instructor_id)
    end
  end
  