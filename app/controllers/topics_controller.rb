class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(params.require(:topic).authorize(:name, :description, :public))
    authorize @topic

    if @topic.save
      flash[:notice] = "Topic was Created."
      redirect_to @topic
    else
      flash[:error] = "There was a problem creating the Topic. Try again!"
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 5)
    
    authorize @topic
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic

    if @topic.update_attributes(params.require(:topic).authorize(:name, :description, :public))
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the Topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name

    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the Topic. Please try again."
      render :show
    end
  end

end
