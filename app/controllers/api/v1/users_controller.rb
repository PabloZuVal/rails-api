class Api::V1::UsersController < ApplicationController
    include ResponseHelper
    before_action only:[:show, :updateUser, :deleteUser]
    skip_before_action :verify_authenticity_token, only: [:create,:updateUser,:deleteUser]

    # GET /users
    def users        
        @users = User.all
        return render json: { msj: "User list empty" }, status: :unprocessable_entity unless @users
    
        return render json: @users, status: :ok
    end
    
    # POST /users/
    def create
        print "parametros del request"
        print userparams
        
        @user = User.new(userparams)
        return render json: {msj: "User not added"}, status: :unprocessable_entity unless @user.save()
        
        return render json: @user, status: :ok
    end

    def show
        @user = User.find(params[:id])
        # return render json: { msj: 'User not found', status: :unprocessable_entity } unless @user.present?
        return not_found_render("user", @user) unless @user.present?
        
        return render json: @user, status: :ok
    end
    
    def updateUser
        @user = User.find(params[:id])

        return render json:{msj: "User not found"} , status: :unprocessable_entity unless @user
        return render json: {msj: "Update Failed"}, status: :unprocessable_entity unless @user.update(userparams)

        return render json: @user, status: :ok

    end

    def deleteUser
        @user = User.find(params[:id])
        return  render json: {msj:"User not found"}, status: :unprocessable_entity unless @user
        return render json: {msj: "Delete failed"}, status: :unprocessable_entity unless @user.destroy()

        return render json: {msj: "User Deleted"}, status: :ok
    end

    private
        def userparams
            params.permit(:name,:email,:direction,:phone,:credit_card_id)
        end

        def getUser
            @user = User.find(params[:id])
        end
    
end
