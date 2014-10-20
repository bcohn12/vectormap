function [ name ] = full_muscle_name(muscle_number,abbrev )
%1 gets you adf

if abbrev==true
    names = {       'adf'  ;
				'adl'  ;
				'bfa'  ;
				'bfp'  ;
				'edl'  ;
				'fdl' ;
				'fhl'  ;
				'gmax' ;
				'gmed' ;
				'gmin';
				'grac' ;
				'lg'   ;
				'mg'   ;
				'pb'   ;
				'pec'  ;
				'pl'   ;
				'plan' ;
				'psoas';
				'pt'   ;
				'pyr'  ;
				'qf'   ;
				'rf'   ;
				'sart' ;
				'sm'   ;
				'sol'  ;
				'st'   ;
				'ta'   ;
				'tp'   ;
				'vi'   ;
				'vl'   ;
				'vm' };
            
else
    names = {'Adductor femoris',
'Adductor longus',
'Biceps femoris anterior',
'Biceps femoris posterior',
'Extensor digitorum longus',
'Flexor digitorum longus',
'Flexor hallicus longus',
'Gluteus maximus',
'Gluteus medius',
'Gluteus minimus',
'Gracilis',
'Lateral gastrocnemius',
'Medial gastrocnemius',
'Peroneus brevis',
'Pectineus',
'Peroneus longus',
'Plantaris',
'Iliopsoas',
'Peroneus tertius',
'Pyriformis',
'Quadratus femoris',
'Rectus femoris',
'Sartorius',
'Semimembranossus',
'Soleus',
'Semitendinosus',
'Tibialis anterior',
'Tibialis posterior',
'Vastus intermedius',
'Vastus lateralis',
'Vastus medialis'};

end
name = names(muscle_number,:);

