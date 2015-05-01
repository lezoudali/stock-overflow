class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_forum_thread, except: [:index, :new, :create]
  impressionist actions: [:show]

  def index
    @q = ForumThread.search(params[:q])
    @forum_threads = @q.result(distinct: true).order('created_at desc')
  end

  def show
    @forum_post = ForumPost.new
  end

  def new
    @forum_thread = ForumThread.new
  end

  def create 
    @forum_thread = current_user.forum_threads.new forum_thread_params

    if @forum_thread.save
      redirect_to @forum_thread
    else
      render action: :new
    end  
  end

  def destroy
    @forum_thread.destroy
    redirect_to forum_threads_path
  end

  private

  def set_forum_thread
    @forum_thread = ForumThread.find(params[:id])
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:subject, :content)
  end
end