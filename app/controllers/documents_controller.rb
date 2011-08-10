class DocumentsController < ApplicationController
  
  layout "modal"
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_document_block
  before_filter :find_or_build_document
 
 

  # GET /documents/1
  # GET /documents/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
   respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
   
  end

  # POST /documents
  # POST /documents.json
  def create
    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_document_block_path(@document.document_block), notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
   

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to edit_document_block_path(@document.document_block), notice: 'Document was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    
    @document.destroy
    respond_to do |format|
      format.html { redirect_to edit_document_block_path(@document.document_block) }
      format.json { head :ok }
    end
  end
  
  protected 
    def find_document_block
        @document_block = DocumentBlock.find(params[:document_block_id])
    end
    def find_or_build_document
        @document = params[:id] ? @document_block.documents.find(params[:id]) : @document_block.documents.build(params[:document])
    end
    
end
