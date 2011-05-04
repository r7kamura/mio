class WikiController < ApplicationController
  def index
    @pages = Page.order("updated_at DESC").page(params[:page])
  end

  def show
    unless @page = Page.where(:name => params[:name]).first
      redirect_to wiki_index_url; return
    end
  end

  def edit
    if params[:name]
      @page = Page.where(:name => params[:name]).first || Page.new
    else
      @page = Page.new
    end
  end

  def update
    if params[:id]
      @page = Page.find(params[:id]).first
    else
      @page = Page.new
    end
    @page.attributes = {
      :name   => params[:name],
      :body   => params[:body],
      :title  => params[:title],
    }
    if @page.save
      flash[:message] = t("saved")
      redirect_to wiki_show_url(@page.name)
    else
      flash[:message] = t("failed")
      redirect_to wiki_edit_url(@page.name)
    end
  end

  def delete
    Page.find(params[:id]).delete
    redirect_to wiki_index_url
  end

end
