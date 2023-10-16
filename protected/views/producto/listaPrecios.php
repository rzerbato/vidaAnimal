<?php

//$pdf = Yii::createComponent('application.extensions.MPDF60.mpdf');
$reporte = '

    <link rel="stylesheet" type="text/css" href="'.Yii::app()->request->baseUrl.'/css/mpdfstyletables.css" />
      <style>
        table {
          border-collapse: collapse;
        }
        table, td, th {
          border: 1px solid;
        }
      </style>


      <h1><center>Lista de Precios</center></h1>
      <table repeat_header="1">
        <thead>
          <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Marca</th>
            <th>Precio Costo</th>
            <th>Precio Efectivo</th>
            <th>Precio 2</th>
            <th>Precio 3</th>
          </tr>
        </thead>
      <tbody>';
        foreach($productos as $row){
$reporte = $reporte.'
          <tr>
            <td>'.
                $row->codigo.
            '</td>
            <td>'.
              $row->nombre.
            '</td>
            <td>'.
              Marca::model()->findByPK($row->marca_idmarca)->nombre.
            '</td>
            <td>
              $'.$row->precioCosto.
            '</td>
            <td>
              $'.$row->precioEfectivo.
            '</td>
            <td>
              $'.$row->precio2.
            '</td>
            <td>
              $'.$row->precio3.
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
$nombre = 'Lista de Precios al '.$hoy[mday].'-'.$hoy[mon].'-'.$hoy[year].'.pdf';
$mpdf->Output($nombre, 'D');

?>
