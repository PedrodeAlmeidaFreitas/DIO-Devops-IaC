#!/bin/bash
declare -a USUARIOS_ADM = ('carlos', 'maria', 'joao')
declare -a USUARIOS_VEN = ('debora', 'sebastiana', 'roberto')
declare -a USUARIOS_SEC = ('josefina', 'amanda', 'rogerio')
declare -a TODOS_USUARIOS += ("${USUARIOS_ADM[@]}" "${USUARIOS_VEN[@]}" "${USUARIOS_SEC[@]}") 

echo "Removendo pastas comuns"

rm -Rf /publico /adm /ven /sec

echo "Removendo usuarios"

for user in TODOS_USUARIOS
do
    userdel -r $user
done

echo "Criando diretorios"

mkdir /publico /adm /ven /sec

echo "Criando grupos"

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Criando usuarios"

for user in TODOS_USUARIOS
do
    useradd $user -m -s /bin/bash -p $(openssl passwd -crypt Senha123)
done

echo "Adicionando grupos"

for user in USUARIOS_ADM
do
    usermod -a -G GRP_ADM $user
done

for user in USUARIOS_SEC
do
    usermod -a -G GRP_SEC $user
done

for user in USUARIOS_VEN
do
    usermod -a -G GRP_VEN $user
done

echo "Permissoes diretorios"

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico
