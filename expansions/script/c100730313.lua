--高速决斗技能-卡组统领：速攻的黑衣忍者
Duel.LoadScript("speed_duel_common.lua")
function c100730313.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730313.skill,c100730313.con,aux.Stringid(100730313,0))
	aux.SpeedDuelAtMainPhase(c,c100730313.skill1,c100730313.con1,aux.Stringid(100730313,1))
	aux.SpeedDuelAtMainPhase(c,c100730313.skill2,c100730313.con2,aux.Stringid(100730313,2))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730313.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=5000
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_SZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x2b,0x61)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c100730313.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local c=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND,0,1,1,nil,0x2b,0x61):GetFirst()
	Duel.SendtoGrave(c,REASON_EFFECT)
	Duel.Hint(HINT_CARD,1-tp,100730313)
	local tc=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_SZONE,1,1,nil):GetFirst()
	if tc:IsLocation(LOCATION_FZONE) then
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,tc:GetPosition(),true)
	else
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,tc:GetPosition(),true)
	end
	e:Reset()
end
function c100730313.con1(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730313.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,64801562)
		and Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c100730313.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x2b) and c:IsStatus(STATUS_SUMMON_TURN)
end
function c100730313.eqfilter(c)
	return c:IsType(TYPE_EQUIP)
end
function c100730313.skill1(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730313)
	local g1=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_MZONE,0,1,1,nil,0x2b)
	local tc=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,64801562)
	local eqc=g2:GetFirst()
	Duel.Equip(tp,eqc,tc)
	local c=Duel.CreateToken(1-tp,13250922)
	Duel.SendtoHand(c,nil,REASON_RULE)
	if tc:GetAttack()<=1300 then
		local ft=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
		local g=Duel.SelectMatchingCard(tp,c100730313.eqfilter,tp,LOCATION_DECK,0,1,ft,nil)
		Duel.SSet(1-tp,g)
	else Duel.Destroy(eqc,REASON_EFFECT)
	end
end
function c100730313.con2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=5000
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_SZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c100730313.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local c=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_SZONE,1,1,nil):GetFirst()
	Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
	Duel.Hint(HINT_CARD,1-tp,100730313)
	local tc=Duel.CreateToken(tp,41006930)
	Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
	e:Reset()
end