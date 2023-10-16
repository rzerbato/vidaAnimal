<?php

//$pdf = Yii::createComponent('application.extensions.MPDF60.mpdf');
$reporte = '

    <link rel="stylesheet" type="text/css" href="'.Yii::app()->request->baseUrl.'/css/mpdfstyletables.css" />
    <style>
        h1 {
            text-align: center;
        }        
        table.cabecera {
            witdh: 100%;
        }
        td.key {
            width: 20%:
        }
        table.detalle {
            border-collapse: collapse;
            width: 100%;
        }
        td.fecha{
            width: 15%;
        }

        table.detalle, table.detalle td, table.detalle th {
            border: 1px solid;
        }
    </style>

        <h1>Historia Clínica</h1>
        <table class="cabecera">
            <tr>
                <td class="key">Paciente:</td>
                <td class="value">'.$pacienteModel->nombre.'.</td>
                <td class="key">Sexo:</td>
                <td class="value">'.$pacienteModel->sexo.'.</td>
            </tr>
            <tr>
                <td class="key">Fecha de Nacimiento:</td>
                <td class="value">'.date('d-m-Y', strtotime($pacienteModel->fechaNacimiento)).'.</td>
                <td class="key">Especie:</td>
                <td class="value">'.$pacienteModel->especieIdespecie->nombre.'.</td>
            </tr>
            <tr>
                <td class="key">Raza:</td>
                <td class="value">'.$pacienteModel->razaIdraza->nombre.'.</td>
                <td class="key">Seña Particular:</td>
                <td class="value">'.$pacienteModel->señaParticular.'.</td>
            </tr>            
            <tr>
                <td class="key">Observación:</td>
                <td colspan="3" class="value">'.$pacienteModel->observacion.'.</td>
            </tr>            
        </table>

        <table repeat_header="1" class="detalle">
        <thead>
          <tr>
            <th>Fecha</th>
            <th>Motivo</th>            
          </tr>
        </thead>
      <tbody>';      
        foreach($consultas as $row){
            $reporte = $reporte.'
            <tr>
                <td class="fecha">'.
                    date('d-m-Y', strtotime($row->fecha)).
                '</td>
                <td>'.
                    $row->motivo.
                '</td>
            </tr>';
        };
$reporte = $reporte.
    '</tbody>
    </table>';
    $mpdf=new mPDF('win-1252','LETTER','','',15,15,25,12,5,7);
    $mpdf->SetDisplayMode('fullpage');
    $mpdf->list_indent_first_level = 0;
    $mpdf->pagenumPreffix = 'Page number';
    $mpdf->pagenumSuffix = ' - ';
    $mpdf->nbpgPreffix = ' out of ';
    $mpdf->nbpgSuffix = ' Páginas ';
    $mpdf->SetFooter('{PAGENO}{nbpg}');
$mpdf->WriteHTML($reporte);
$hoy = getdate();
$nombre = 'Historia Clinica de '.$pacienteModel->nombre.' al '.$hoy[mday].'-'.$hoy[mon].'-'.$hoy[year].'.pdf';
$mpdf->Output($nombre, 'D');

?>
