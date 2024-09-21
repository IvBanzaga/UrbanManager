* **`ON DELETE RESTRICT`** : Impide la eliminación si hay registros relacionados.
* **`ON DELETE CASCADE`** : Si se elimina un registro en la tabla padre, también se eliminarán los registros relacionados en la tabla hija.
* **`ON DELETE SET NULL`** : Si se elimina un registro en la tabla padre, el campo en la tabla hija se establece a `NULL`.
* **`ON UPDATE CASCADE`** : Si se actualiza el valor de la clave primaria en la tabla referenciada, la actualización se propaga a las tablas hijas.
