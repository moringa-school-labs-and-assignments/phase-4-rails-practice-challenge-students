class InstructorsController < ApplicationController
  
  def index
    instructors = Instructor.all 
    render json: instructors, status: :ok
  end

  def show
    instructor = Instructor.find_by(id: params[:id])
    render json: instructor, status: :ok
  end
  
  def create
    instructor = Instructor.new(instructor_params)

    if instructor.save
      render json: instructor, status: :ok
    else
      render json:  {errors:"Invalid input" }, status: :unprocessable_entity
    end
  end

  def update
    instructor = Instructor.find(params[:id])
  
    if instructor.update(instructor_params)
      render json: instructor, status: :ok
    else
      render json: { errors: "Invalid input" }, status: :unprocessable_entity
    end
  end
  
  def destroy
    instructor = Instructor.find(params[:id])

    if instructor.destroy
      head :no_content, status: :ok
    else
      render json: {errors:"Not found"}
    end
  end
  

  private

  def instructor_params
    params.permit(:name)
  end  
end
