BEGIN{
 str=strftime("%b.%d.%Y");
 comment="ckino " str ": ";
}
/real\(8\),pointer :: rv_p_og/{
print comment, $0
next
}
/rv_p_og => slat%rv_p_osymgr/{
 print comment, $0
next
}
/call symprj \( nrclas , nlmx , ngrp , nbas , slat%iv_p_oistab , rv_p_og/{
 print comment,$0
 sub("rv_p_og","slat%rv_p_osymgr")
}
{ print }

