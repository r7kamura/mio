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
    if params[:id].nil? || params[:id].empty?
      @page = Page.new
    else
      @page = Page.find(params[:id])
    end
    @page.attributes = {
      :name   => params[:name],
      :body   => params[:body],
    }
    if @page.save
      redirect_to wiki_show_url(@page.name)
    else
      redirect_to wiki_edit_url(@page.name)
    end
  end

  def delete
    Page.find(params[:id]).delete
    redirect_to wiki_index_url
  end

end
