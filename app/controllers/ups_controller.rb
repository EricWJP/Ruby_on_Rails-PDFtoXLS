class UpsController < ApplicationController
  before_action :set_up, only: [:show, :edit, :update, :destroy]

  # GET /ups
  # GET /ups.json
  def index
    @ups = Up.all
  end

  # GET /ups/1
  # GET /ups/1.json
  def show
    @ups = Up.all
    var = `echo '#{@up.file}' | sed 's/^.*\?//'`
    `echo '#{@up.file}' | sed 's/\?.*$// ; s/^/public/' > pdf_'#{var}'`
    `echo '#{@up.file(:xls)}' | sed 's/\?.*$// ; s/^/public/' > xls_'#{var}' ; paste -d ' ' pdf_'#{var}' xls_'#{var}' > file_'#{var}'`
    system("pdf=`cat pdf_'#{var}'` ; pdftotext -q -layout $pdf")
    system("txt=`cat pdf_'#{var}' | sed 's/\.pdf$//'` ; sed 's/'\f'// ; s/   \+/  /g ; s/  /\t/g ; s/\t/\",\"/g ; s/^/\"/ ; s/$/\"/' $txt.txt > $txt.csv")
    system("xls=`cat pdf_'#{var}' | sed 's/\.pdf$//'` ; ssconvert $xls.csv  $xls.xls > /dev/null ; rm -f $xls.txt $xls.csv ")
    system("file=`cat file_'#{var}' | sed 's/^/mv / ; s/\.pdf /\.xls /' > file_'#{var}'.sh` ; chmod 775 file_'#{var}'.sh ; ./file_'#{var}'.sh")
    `rm -f rm -f file_'#{var}'.sh file_'#{var}' pdf_'#{var}' xls_'#{var}'`
  end

  # GET /ups/new
  def new
    @up = Up.new
  end

  # GET /ups/1/edit
  def edit
  end

  # POST /ups
  # POST /ups.json
  def create
    @up = Up.new(up_params)

    respond_to do |format|
      if @up.save
        format.html { redirect_to @up, notice: 'Up was successfully created.' }
        format.json { render :show, status: :created, location: @up }
      else
        format.html { render :new }
        format.json { render json: @up.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ups/1
  # PATCH/PUT /ups/1.json
  def update
    respond_to do |format|
      if @up.update(up_params)
        format.html { redirect_to @up, notice: 'Up was successfully updated.' }
        format.json { render :show, status: :ok, location: @up }
      else
        format.html { render :edit }
        format.json { render json: @up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ups/1
  # DELETE /ups/1.json
  def destroy
    @up.destroy
    respond_to do |format|
      format.html { redirect_to ups_url, notice: 'Up was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_up
      @up = Up.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def up_params
      params.require(:up).permit(:file, :name)
    end
end
