class DocumentBlocksController < ApplicationController
  

  # GET /document_blocks/1
  # GET /document_blocks/1.json
  def show
    @document_block = DocumentBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document_block }
    end
  end

  # GET /document_blocks/new
  # GET /document_blocks/new.json
  def new
    @document_block = DocumentBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document_block }
    end
  end

  # GET /document_blocks/1/edit
  def edit
    @document_block = DocumentBlock.find(params[:id])
  end

  # POST /document_blocks
  # POST /document_blocks.json
  def create
    @document_block = DocumentBlock.new(params[:document_block])

    respond_to do |format|
      if @document_block.save
        format.html { redirect_to edit_portfolio_project_path(@document_block.project), notice: 'Document block was successfully created.' }
        format.json { render json: @document_block, status: :created, location: @document_block }
      else
        format.html { render action: "new" }
        format.json { render json: @document_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /document_blocks/1
  # PUT /document_blocks/1.json
  def update
    @document_block = DocumentBlock.find(params[:id])

    respond_to do |format|
      if @document_block.update_attributes(params[:document_block])
        format.html {  redirect_to edit_portfolio_project_path(@document_block.project), notice: 'Document block was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @document_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_blocks/1
  # DELETE /document_blocks/1.json
  def destroy
    @document_block = DocumentBlock.find(params[:id])
    @document_block.destroy

    respond_to do |format|
      format.html { redirect_to edit_portfolio_project_path(@document_block.project) }
      format.json { head :ok }
    end
  end
end
