class JaBlockedRootsController < ApplicationController
  # GET /ja_blocked_roots
  # GET /ja_blocked_roots.json
  def index
    @ja_blocked_roots = JaBlockedRoot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ja_blocked_roots }
    end
  end

  # GET /ja_blocked_roots/1
  # GET /ja_blocked_roots/1.json
  def show
    @ja_blocked_root = JaBlockedRoot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ja_blocked_root }
    end
  end

  # GET /ja_blocked_roots/new
  # GET /ja_blocked_roots/new.json
  def new
    @ja_blocked_root = JaBlockedRoot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ja_blocked_root }
    end
  end

  # GET /ja_blocked_roots/1/edit
  def edit
    @ja_blocked_root = JaBlockedRoot.find(params[:id])
  end

  # POST /ja_blocked_roots
  # POST /ja_blocked_roots.json
  def create
    @ja_blocked_root = JaBlockedRoot.new(params[:ja_blocked_root])

    respond_to do |format|
      if @ja_blocked_root.save
        format.html { redirect_to @ja_blocked_root, notice: 'Ja blocked root was successfully created.' }
        format.json { render json: @ja_blocked_root, status: :created, location: @ja_blocked_root }
      else
        format.html { render action: "new" }
        format.json { render json: @ja_blocked_root.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ja_blocked_roots/1
  # PUT /ja_blocked_roots/1.json
  def update
    @ja_blocked_root = JaBlockedRoot.find(params[:id])

    respond_to do |format|
      if @ja_blocked_root.update_attributes(params[:ja_blocked_root])
        format.html { redirect_to @ja_blocked_root, notice: 'Ja blocked root was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ja_blocked_root.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ja_blocked_roots/1
  # DELETE /ja_blocked_roots/1.json
  def destroy
    @ja_blocked_root = JaBlockedRoot.find(params[:id])
    @ja_blocked_root.destroy

    respond_to do |format|
      format.html { redirect_to ja_blocked_roots_url }
      format.json { head :no_content }
    end
  end
end
