class SubsController < ApplicationController

    before_action :ensure_signed_in, only: [:edit,:update,:new,:create]
    
    def new
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)

        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def index
        @sub = Sub.all
        render :index
    end

    def edit 
        @sub = Sub.find(params[:id])
        render :edit
    end

    def update
        @sub = Sub.find(params[:id])

        if current_user.id == @sub.moderator_id
            if @sub.update(sub_params)
                redirect_to sub_url(@sub)
            else
                flash.now[:errors] = @sub.errors.full_messages
                render :edit
            end
        else
            flash[:errors] = ["You do not own this sub."]
        end
        redirect_to sub_url(@sub.id)
    end

    private 

    def sub_params
        params.require(:sub).permit(:title,:description,:moderator_id)
    end
end
