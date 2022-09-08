module Api
  class SurveysController < ApplicationController
    before_action :set_survey, only: [:show, :update, :destroy]

    # GET /surveys
    def index
      @surveys = Survey.all.includes(questions: :answers)
      # @questions = Question.all.includes(:answers)
      # @surveys.collect{ |survey| survey.questions }


      # render json: @surveys, include:['questions', 'answers']
      render json: @surveys.to_json(include: {questions: {include: :answers} })
    end

    # GET /surveys/1
    def show
      render json: @survey
    end

    # POST /surveys
    def create
      @survey = Survey.new(params.require(:survey).permit(:title, :description, questions_attributes: [
            :_destroy,
            :id,
            :question_type,
            :title,
            answers_attributes: [
              :_destroy,
              :id,
              :title
            ]
          ]))

      if @survey.save
        render json: @survey, status: :created, location: api_surveys_path(@survey)
      else
        render json: @survey.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /surveys/1
    def update
      if @survey.update(survey_params)
        render json: @survey
      else
        render json: @survey.errors, status: :unprocessable_entity
      end
    end

    # DELETE /surveys/1
    def destroy
      @survey.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_survey
        @survey = Survey.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def survey_params
        params.fetch(:survey, {})
      end
  end
end