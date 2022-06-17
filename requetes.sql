
select el_nom,el_prenom,round((note_compo*2+note_classe)/3,2) MG 
			from eleves join notes using(el_id) join matieres using(ma_id) 
									join inscriptions using(el_id) join classes using(cl_id) 
									join series using(se_id) 
			where se_niveau = 10 and periode = 'T1' and annee = 2022 
						and ma_nom ilike 'MATH%' 
						and ((note_compo*2+note_classe)/3) = 
						(
								select max((note_compo*2+note_classe)/3) 
								from notes join eleves using(el_id) join matieres using(ma_id)
								 			join inscriptions using(el_id) join classes using (cl_id) 
								 			join series using(se_id) 
								 			where se_niveau = 10 and periode = 'T1' 
								 			and annee = 2022 and ma_nom ilike 'MATH%'
						); 
														
select  el_nom Nom,el_prenom Prenom,
				round(sum((note_compo*2+note_classe)/3*mats_coef),2) total,
				round(sum((note_compo*2+note_classe)/3*mats_coef)/sum(mats_coef),2) moyenne 
		from eleves join inscriptions using(el_id) join classes using (cl_id) 
								join notes using (el_id) join matseries using(ma_id,se_id) 
		where periode='T1' and annee=2022 and cl_nom = 'CG 1' 
		group by el_nom,el_prenom 
		order by moyenne desc;

select el_nom, el_prenom,periode,round((note_compo*2+note_classe)/3,2) moyenne
	from eleves join notes using(el_id) join matieres using(ma_id) join inscriptions using(el_id) 		join classes using(cl_id) where ma_nom ilike 'BIO%' and periode in('T1','T2')
			and annee = 2022 and cl_nom ='CG 1' and ((note_compo*2+note_classe)/3)<10 order by moyenne;
			
select * from 
	( 
		(select el_nom,el_prenom,((note_compo*2+note_classe)/3)::numeric(4,2) MG 
				 from eleves join notes using(el_id) join matieres using(ma_id) 
				 join inscriptions using(el_id) join classes using(cl_id) join series using(se_id) 
				 where se_nom = 'TSECO' and periode = 'S1' and annee = 2022 and ma_nom ilike 'MATH%'
				 order by MG desc limit 3
		) 
		union 
		(select el_nom,el_prenom,((note_compo*2+note_classe)/3)::numeric(4,2) MG 
				from eleves join notes using(el_id) join matieres using(ma_id) 
				join inscriptions using(el_id) join classes using(cl_id) join series using(se_id) 
				where se_nom = 'TSECO' and periode = 'S1' and annee = 2022 and ma_nom ilike 'MATH%' 
				order by MG  limit 3
		)
	) as tmp 
	order by MG desc;
			
			

select pro_prenom,pro_nom 
     from 
         (select pro_prenom,pro_nom,count(*) nb_cours from cahiertextes join emploi_temps     	        using(em_id) join cours using(co_id) join professeurs using(pro_id) 
     where extract(year from ca_date)=2022 and extract(month from ca_date)=4  group by 						                                                  pro_id,pro_prenom,pro_nom) as ca 
     join 
     (select pro_prenom,pro_nom,count(*)*4 nbcours from professeurs join cours using(pro_id)     join    emploi_temps using(co_id)  group by pro_id) as co using(pro_nom,pro_prenom) 
     
    where nb_cours < nbcours;
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
