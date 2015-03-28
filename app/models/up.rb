class Up < ActiveRecord::Base
	 has_attached_file :file, :styles => {:thumb => ["100x100>", :png], :xls => ["", :xls]}
     validates_attachment_content_type :file, :content_type => ['application/pdf']
end
