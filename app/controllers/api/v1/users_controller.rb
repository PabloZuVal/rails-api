class Api::V1::UsersController < ApplicationController

    before_action only:[:show, :updateUser, :deleteUser]
    skip_before_action :verify_authenticity_token, only: [:create,:updateUser,:deleteUser]

    # GET /users
    def users        
        users = User.all

        if users
            render json: users, status: :ok
        else
            render json: { msj: "User list empty" }, status: :unprocessable_entity 
        end

    end
    
    # POST /users/
    def create
        user = User.new(userparams)

        if user.save()
            render json: user, status: :ok
        else
            render json: {msj: "User not added"}, status: :unprocessable_entity
        end
    end


    def show
        # print "id llegada"
        # print params[:id]
        @user = User.find(params[:id])
        # print 'inicio'
        # print @user
        # print 'fin'
        # if @user.present?
        if @user
            print "usuario encontrado"
            render json: @user, status: :ok
        else
            print "Usuario no encontrado"
            render json: {msj: "User not found"}, status: :unprocessable_entity
        end
        
    end
    
    def updateUser
        @user = User.find(params[:id])

        if @user
            if @user.update(userparams)
                render json: @user, status: :ok
            else
                render json: {msj: "Update Failed"}, status: :unprocessable_entity
            end
        else
            render json:{msj: "User not found"} , status: :unprocessable_entity
        end
    end

    def deleteUser
        @user = User.find(params[:id])

        if @user
            if @user.destroy()
                render json: {msj: "User Deleted"}, status: :ok
            else
                render json: {msj: "Delete failed"}, status: :unprocessable_entity
            end
        else
            render json: {msj:"User not found"}, status: unprocessable_entity
        end
    end

    private
        def userparams
            params.permit(:name,:email,:direction,:phone,:credit_card_id)
        end

        def getUser
            @user = User.find(params[:id])
        end
    

end
