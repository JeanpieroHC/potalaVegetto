
use strict;
use CGI;
use warnings;
use utf8;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../estilosPerl.css">
<title>Búsquedas Universidades Licenciadas </title>
</head>
<body>
<div class="contenedor-busqueda">
HTML

my $q =CGI->new;
my $usuario=$q->param("usuario");
my $contraseña=$q->param("contraseña");
my $nombre=$q->param("nombre");
my $correo=$q->param("correo");


if(!($usuario eq "") and !($contraseña eq "") and !($nombre eq "") and !($correo eq "")){
    registrarUsuario($usuario,$contraseña,$nombre,$correo);
}else{
    print "<h1>Escribe todos los campos</h1>";
}

sub registrarUsuario{
    my $usuario=$_[0];
    my $contrasena=$_[1];
    my $nombre=$_[2];
    my $correo=$_[3];


    open(OUT,">../database/users.txt") or die"ERROR";
        print OUT " $usuario|$contrasena|$nombre|$correo ";
    close (OUT);


}

sub imprimirResultados{
    my $expresion=$_[0];
    my @columnas;
    open(IN,"../UniversidadesLicenciadas.csv") or die"ERROR";

    while(my $line = <IN>){
    $line =~ tr/ÁÉÍÓÚ/AEIOU/;
        if($line =~ /$expresion/){

            @columnas=split("\\|",$line);
            print <<HTML;
            <div class="contenedor-resultados">

HTML
            for(my $i=1;$i<23;$i++ ){
                print <<HTML;
            <div>

HTML
                print <<HTML;
            </div>

HTML
            }

        print <<HTML;
        </div>

HTML
        }
    }

    close (IN);
}
