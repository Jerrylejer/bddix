--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select * from potion;

--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select nom_categ as nom_des_trophees_rapportant_3_points from categorie where nb_points = 3; 

--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select nom_village as villages_de_plus_de_35_huttes from village where nb_huttes > 35;

--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select num_trophee as numeros_de_trophee_pris_entre_mai_52_et_juin_52 from trophee where date_prise between '2052-05-01' and '2052-06-30';

--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select nom as noms_des_habitants_commencant_par_a_et_contenant_r from habitant where nom like 'A%r%';

--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select distinct num_hab as Num_des_habitants_ayant_bu_les_potions_1_3_ou_4 from absorber where num_potion in (1, 3, 4);

--6A. Noms des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select distinct nom as Noms_des_habitants_ayant_bu_les_potions_1_3_ou_4 from habitant join absorber on habitant.num_hab = absorber.num_hab where num_potion in (1, 3, 4);

--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select num_trophee, TO_CHAR(date_prise , 'DD/MM/YY') as date_prise, categorie.nom_categ, habitant.nom from trophee join categorie on trophee.code_cat = categorie.code_cat join habitant on trophee.num_preneur = habitant.num_hab;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select nom as habitants_de_Aquilna from habitant join village on habitant.num_village = village.num_village and village.nom_village = 'Aquilona';

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select nom as habitants_trophee_de_Bouclier_de_Legat from habitant join trophee on habitant.num_hab = trophee.num_preneur where code_cat = 'BLT';

--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select distinct lib_potion as potions_fabriquees_par_Panoramix, formule, constituant_principal from potion join fabriquer on potion.num_potion = fabriquer.num_potion join habitant on fabriquer.num_hab = habitant.num_hab where nom = 'Panoramix';

--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select distinct lib_potion as potion_absorbees_par_Homeopatix  from potion join absorber on potion.num_potion = absorber.num_potion join habitant on absorber.num_hab = habitant.num_hab where nom = 'Homéopatix';

--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct nom as habitants_ayant_bu_potions_fabriquees_par_habitant_3 from habitant join absorber on habitant.num_hab = absorber.num_hab join potion on absorber.num_potion = potion.num_potion join fabriquer on potion.num_potion = fabriquer.num_potion where fabriquer.num_hab = 3;

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct habitant.nom as habitants_ayant_bu_potion_amnesix from habitant join absorber on habitant.num_hab = absorber.num_hab join fabriquer on absorber.num_potion = fabriquer.num_potion join habitant hab on fabriquer.num_hab = hab.num_hab where hab.nom = 'Amnésix';

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select nom as Habitants_sans_qualité from habitant where num_qualite is null;

--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select nom as habitants_Potion_1_fevrier_52 from habitant join absorber on habitant.num_hab = absorber.num_hab where absorber.num_potion = 1 and absorber.date_a between '2052-02-01' and '2052-02-28';

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select nom as noms, age as ages from habitant order by nom;

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select nom_resserre as resserre, village.nom_village as Village from resserre join village on resserre.num_village = village.num_village order by resserre.superficie;
--***

--18. Nombre d'habitants du village numéro 5. (4)
select COUNT(*) as nombre_hab_village_5 from habitant join village on habitant.num_village = village.num_village where village.num_village = 5;

--19. Nombre de points gagnés par Goudurix. (5)
select SUM(nb_points) as points_gagnants_Goudurix from categorie join trophee on categorie.code_cat = trophee.code_cat join habitant on trophee.num_preneur = habitant.num_hab where habitant.nom = 'Goudurix';

--20. Date de première prise de trophée. (03/04/52)
select TO_CHAR(date_prise , 'DD/MM/YY') as date_premiere_prise_trophee from trophee limit 1 offset 1;

--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum(quantite) Q_louches_potion_2_absorbee from absorber where absorber.num_potion = 2;

--22. Superficie la plus grande. (895)
select max(superficie)as resserre_la_plus_grande from resserre;
--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select village.nom_village, count(*) as nombre_habitants from habitant join village on habitant.num_village = village.num_village group by village.nom_village;

--24. Nombre de trophées par habitant (6 lignes)
select habitant.nom as noms, count(num_preneur) as nombre_de_trophees from trophee join habitant on trophee.num_preneur = habitant.num_hab group by habitant.nom;


--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select province.nom_province as nom_de_province, avg(age) as age_moyen_habitant from habitant join village on habitant.num_village = village.num_village join province on village.num_province = province.num_province group by province.nom_province;

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)
select habitant.nom, count(lib_potion) as nombre_potions_differentes_bues from potion join absorber on potion.num_potion = absorber.num_potion join habitant on absorber.num_hab = habitant.num_hab group by habitant.nom;

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select nom as hab_ayant_bu_plus_de_2_louches_potion_Zen from habitant join absorber on habitant.num_hab = absorber.num_hab join potion on absorber.num_potion = potion.num_potion where potion.lib_potion = 'Potion Zen' and absorber.quantite > 2; 

--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select nom_village as villages_avec_resserre from village join resserre on village.num_village = resserre.num_village;

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select nom_village as village_avec_plus_de_huttes from village order by nb_huttes desc limit 1;

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes)=> Sans aide => je n'y arrive pas par le nom. Seconde requête grâce à entraide
select distinct nom from habitant join trophee on habitant.num_hab = trophee.num_preneur group by habitant.nom having count(trophee.num_preneur) > 1;
select nom from habitant join trophee on habitant.num_hab = trophee.num_preneur group by habitant.num_hab, habitant.nom having count(trophee.num_trophee) > (select count(*) from trophee where num_preneur = (select num_hab from habitant where nom = 'Obélix'));

