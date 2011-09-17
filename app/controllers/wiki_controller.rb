class WikiController < ApplicationController

  def index
    @pages = Page.order("updated_at DESC").page(params[:page])
    @page  = Page.find_by_name("top")
  end

  def show
    @page = Page.find_by_name(params[:name])
    redirect_to wiki_edit_url(params[:name]) unless @page
  end

  def search
    @pages = Page.search(params[:query]).order("updated_at DESC").page(params[:page])
    render :action => :index
  end

  def edit
    @page = Page.find_by_name(params[:name]) if params[:name]
    @page ||= Page.new
  end

  def update
    attr = { name: replace_illegal_name(params[:name]), body: params[:body] }
    @page = params[:id].blank? ?
      Page.new(attr) :
      Page.find(params[:id]).tap{|p| p.attributes = attr}
    @page.save ?
      redirect_to(wiki_show_url @page.name) :
      redirect_to(wiki_edit_url @page.name)
  end

  def delete
    Page.find(params[:id]).destroy
    redirect_to wiki_index_url
  end

  private
  def replace_illegal_name(name)
    name.gsub("/", "-").gsub(".", "-")
  end
end
