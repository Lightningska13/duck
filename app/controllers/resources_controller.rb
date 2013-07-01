class ResourcesController < ApplicationController
	# collection_select bombs if validations run unless we define 
	# @departments here. Doesn't work in New and Edit when validations run
	# put it here instead of in the view (where it works also with validations)
	# This is the same as including the @departments in each of the listed actions
  before_filter :instantiate_departments, :only => [:new, :edit, :create, :update]
  
  def instantiate_departments
  	#@facets = Facet.order('title asc')
  	@rescats = Rescat.order('category asc')
  	@page_title = "#{@current_action.titleize} Resources"
  end

  def sort
  	params[:resource].each_with_index do |id, index|
  		Resource.update_all(['position=?', index+1], ['id=?', id])
#      @resources = Resource.all
#      @resources.each do |resource|
#        resource.position = params['resource'].index(resource.id.to_s) + 1
#        resource.save
      end
  	render :nothing=>true
  end
  
  # GET /resources
  # GET /resources.xml
  def index
  	@page_title = ""
  	if params[:cat]
  		@cat = Rescat.find(params[:cat])
	    @resources = @cat.resources
	    check_normal
	    @title_text= @cat.category
 	    @blurb= @cat.blurb
 	    @page_title= @page_title + @title_text 
  	elsif params[:dept]
  		@dept = Facet.find(params[:dept])
	    @resources = @dept.resources.order(:position)
	    check_normal
	    @title_text= @dept.title
  	  @blurb= (@resources.size == 1 ? "There is 1 result." : "There are #{@resources.size} results.")
 	    @page_title= @page_title + @title_text 
 		elsif params[:search] and (params[:search] != "")
	  	@resources = Resource.search(params[:search])
	    check_normal
	    @title_text='Search Results'
  	  @blurb= (@resources.size == 1 ? "There is 1 result." : "There are #{@resources.size} results.")
 		elsif params[:all]
	  	@resources = Resource.where('rescats.category is null').order(:position).includes(:rescats)
	    check_normal
	    @title_text='Uncategorized'
  	  @blurb= "These are NOT visible to the public by browsing, but will show up in a keyword search. They must be assigned to a category in order to be browsed."
 	  else
	    @resources = Resource.where('featured = ?', true).order(:position)
	    check_normal
	    @title_text='Featured Resources'
 	    @blurb=''
    end
    
    if admin?
    	@cursor_style = 'cursor:move;' # show drag cursor on sortable list
    end
  	@rescats = Rescat.order('category asc').visible
    @restricted = Rescat.restricted

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(@resource, :notice => 'Resource was successfully created.') }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
  	#params[:resource][:facet_ids] ||= []
  	params[:resource][:rescat_ids] ||= []
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to(@resource, :notice => 'Resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def check_normal
    unless member?
      @resources = @resources.visible.order(:position)
    end
  end
end
