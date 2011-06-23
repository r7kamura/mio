class WikiController < ApplicationController

  def index
    @pages = Page.order("updated_at DESC").page(params[:page])
  end

  def show
    @page = Page.find_by_name(params[:name])
    redirect_to wiki_edit_url(params[:name]) unless @page
  end

  def edit
    @page = Page.find_by_name(params[:name]) if params[:name]
    @page ||= Page.new
  end

  def update
    attr = { name: params[:name], body: params[:body] }
    @page = (params[:id].nil? || params[:id].empty?) ?
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

end
