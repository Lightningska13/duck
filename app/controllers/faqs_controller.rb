class FaqsController < ApplicationController
 # For categories - remove the begin/end block to enable
=begin
  before_filter :instantiate_departments, :only => [:new, :edit, :create, :update]
  
  def instantiate_departments
  	@categories = Category.find(:all, :order => :id)
  	#@areas = Area.find(:all, :order => :name)
  	@page_title = "#{@current_action.titleize} FAQs"
  end
  
  def sort
  	params[:faq].each_with_index do |id, index|
  		Faq.update_all(['position=?', index+1], ['id=?', id])
    end
  	render :nothing=>true
  end

  #for listing faq categories on the show and index pages
  def get_dept_cat
    #@faqs = Faq.find(:all, :include=> :services, :order => 'services.name ASC, faqs.position ASC')
    @faqs = Faq.order('categories.category ASC, faqs.position ASC').includes(:categories).all
    @faq_dept = @faqs.group_by(&:categories)  
  end
=end
def sort
	params[:faq].each_with_index do |id, index|
		Faq.update_all(['position=?', index+1], ['id=?', id])
  end
	render :nothing=>true
end
  # GET /faqs
  # GET /faqs.xml
  def index
  	@page_title = ""
 		if params[:search] and (params[:search] != "")
	  	@faqs = Faq.search(params[:search])
	    @title_text='Search Results'
  	  @blurb= (@faqs.size == 1 ? "There is 1 result." : "There are #{@faqs.size} results.")
 		else 
	  	@faqs = Faq.order(:position)
	    @title_text='All FAQs'
  	  @blurb= ''
    end
    
    if admin?
    	@cursor_style = 'cursor:move;' # show drag cursor on sortable list
    end
  	@page_title = "FAQs"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @faqs }
    end
  end

  # GET /faqs/1
  # GET /faqs/1.xml
  def show
    @faq = Faq.find(params[:id])
  	@page_title = @faq.question
		@title='FAQs'

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/new
  # GET /faqs/new.xml
  def new
    @faq = Faq.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @faq }
    end
  end

  # GET /faqs/1/edit
  def edit
    @faq = Faq.find(params[:id])
  end

  # POST /faqs
  # POST /faqs.xml
  def create
    @faq = Faq.new(params[:faq])

    respond_to do |format|
      if @faq.save
        format.html { redirect_to(@faq, :notice => 'Faq was successfully created.') }
        format.xml  { render :xml => @faq, :status => :created, :location => @faq }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /faqs/1
  # PUT /faqs/1.xml
  def update
  	#uncomment if using categories
  	#params[:faq][:category_ids] ||= []
    @faq = Faq.find(params[:id])

    respond_to do |format|
      if @faq.update_attributes(params[:faq])
        format.html { redirect_to(@faq, :notice => 'Faq was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @faq.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.xml
  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy

    respond_to do |format|
      format.html { redirect_to(faqs_url) }
      format.xml  { head :ok }
    end
  end
end
