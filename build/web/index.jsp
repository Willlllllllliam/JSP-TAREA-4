<%@page import="modelo.Empleado" %>
<%@page import="modelo.Puesto" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="java.util.HashMap" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Empleados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        h1 {
            margin-bottom: 30px;
            color: #343a40;
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .table {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Formulario de Empleados</h1>
        <div class="text-center mb-4">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_empleado" onclick="limpiar()">
                Agregar Nuevo Empleado
            </button>
        </div>

        <div class="modal fade" id="modal_empleado" tabindex="-1" aria-labelledby="modal_empleado" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Detalles del Empleado</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_empleado" method="post" class="form-group p-4 bg-light border rounded shadow-sm" style="transition: all 0.3s;">
    <h3 class="text-center text-success mb-4">Formulario de Empleados</h3>

    <div class="mb-3">
        <label for="txt_id" class="form-label"><b>ID</b></label>
        <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
    </div>
    
    <div class="mb-3">
        <label for="txt_codigo" class="form-label"><b>Código:</b></label>
        <input type="text" name="txt_codigo" id="txt_codigo" class="form-control" placeholder="Ejemplo: E001" required>
    </div>
    
    <div class="mb-3">
        <label for="txt_nombres" class="form-label"><b>Nombres:</b></label>
        <input type="text" name="txt_nombres" id="txt_nombres" class="form-control" placeholder="Ejemplo: Nombre 1, Nombre 2" required>
    </div>
    
    <div class="mb-3">
        <label for="txt_apellidos" class="form-label"><b>Apellidos:</b></label>
        <input type="text" name="txt_apellidos" id="txt_apellidos" class="form-control" placeholder="Ejemplo: Apellido 1, Apellido 2" required>
    </div>
    
    <div class="mb-3">
        <label for="txt_direccion" class="form-label"><b>Dirección:</b></label>
        <input type="text" name="txt_direccion" id="txt_direccion" class="form-control" placeholder="Ejemplo: No. casa, calle, zona, ciudad" required>
    </div>
    
    <div class="mb-3">
        <label for="txt_telefono" class="form-label"><b>Teléfono:</b></label>
        <input type="number" name="txt_telefono" id="txt_telefono" class="form-control" placeholder="Ejemplo: 55487941" required>
    </div>
    
    <div class="mb-3">
        <label for="txt_fn" class="form-label"><b>Fecha Nacimiento:</b></label>
        <input type="date" name="txt_fn" id="txt_fn" class="form-control" required>
    </div>
    
    <div class="mb-3">
        <label for="drop_puesto" class="form-label"><b>Puesto:</b></label>
        <select name="drop_puesto" id="drop_puesto" class="form-select">
            <%
                Puesto puesto = new Puesto();
                HashMap<String,String> drop = puesto.drop_sangre();
                for (String i: drop.keySet()){
                    out.println("<option value='"+i+"'>"+drop.get(i)+"</option>");
                }
            %>    
        </select>
    </div>

    <div class="mt-4 d-flex justify-content-between">
        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-success w-30" style="transition: background-color 0.3s;">Agregar</button>
        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-warning w-30" style="transition: background-color 0.3s;">Modificar</button>
        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger w-30" onclick="javascript:if(!confirm('¿Desea Eliminar?'))return false" style="transition: background-color 0.3s;">Eliminar</button>
        <button type="button" class="btn btn-secondary w-30" data-bs-dismiss="modal">Cerrar</button>
    </div>
</form>

                    </div>
                </div>
            </div>
        </div>

        <table class="table table-striped table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Código</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Dirección</th>
                    <th>Teléfono</th>
                    <th>Nacimiento</th>
                    <th>Puesto</th>
                </tr>
            </thead>
            <tbody id="tbl_empleados">
                <%
                    Empleado empleado = new Empleado();
                    DefaultTableModel tabla = empleado.leer();
                    for (int t = 0; t < tabla.getRowCount(); t++){
                        out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "' data-id_p='" + tabla.getValueAt(t, 8) + "'>");
                        out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                        out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script type="text/javascript">
        function limpiar() {
            $("#txt_id").val(0);
            $("#txt_codigo").val('');
            $("#txt_nombres").val('');
            $("#txt_apellidos").val('');
            $("#txt_direccion").val('');
            $("#txt_telefono").val('');
            $("#txt_fn").val('');
            $("#drop_puesto").val(1);
        }

        $('#tbl_empleados').on('click', 'tr', function() {
            var id = $(this).data('id');
            var id_p = $(this).data('id_p');
            var cells = $(this).children('td');
            $("#txt_id").val(id);
            $("#txt_codigo").val(cells.eq(0).text());
            $("#txt_nombres").val(cells.eq(1).text());
            $("#txt_apellidos").val(cells.eq(2).text());
            $("#txt_direccion").val(cells.eq(3).text());
            $("#txt_telefono").val(cells.eq(4).text());
            $("#txt_fn").val(cells.eq(5).text());
            $("#drop_puesto").val(id_p);
            $("#modal_empleado").modal('show');
        });
    </script>
</body>
</html>
