class ReportPDF < Prawn::Document
	def initialize(report, fecha1, fecha2)
		super(
			:page_size => "A4", 
			:page_layout => :landscape, 
			:margin => 50 )
		@report = report
		@fecha_inicio = fecha1
		@fecha_fin = fecha2
		report_number
		line_items
	end

	def report_number
		move_down 10
		font "Helvetica", :size => 12
		text Time.now.to_formatted_s(:db), :align => :right
		font "Helvetica", :size => 16		
		stroke_horizontal_rule
		pad(10) { text "Reporte general de Contratos" , :align => :center, :color => "FF0000" }
		
		if @fecha_inicio.nil? == false and @fecha_fin.nil? == false
		    text @fecha_inicio.to_s + " *** " + @fecha_fin.to_s, :align => :center, :size => 12
		end
	end

	def line_items
		move_down 20
		font "Helvetica", :size => 10		
		table line_item_rows, :width => 750, :column_widths => [170, 170, 170, 50, 95, 95], :row_colors => ["8CB9DC" , "F0F0F0"], :header => true  do
			row(0).font_style = :bold
			columns(0...5).align = :left
			#columns(3).align = :right
		end
	end

	def line_item_rows
		[[ "Nombre de Equipo" , "Proveedor" , "No. de Contrato" , "Monto" , "Fecha inicial" , "Fecha final" ]] +
		@report.map do |rep|
		#@report.line_items.map do |item|
			[rep.contract.device.name, rep.contract.supplier.business_name, rep.contract.contract_no, rep.monto, rep.start_date, rep.end_date]
		end
	end
	#end
end
