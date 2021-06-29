--高速决斗技能-不朽的施舍
Duel.LoadScript("speed_duel_common.lua")
function c100730188.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730188.skill,c100730188.con,aux.Stringid(100730188,0))
	aux.SpeedDuelMoveCardToFieldCommon(80921533,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730188.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730188.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730188.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x21)
end
function c100730188.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,96907086,56339050,29934351)
	if g2:GetCount()==0 then return end
	local qc=g2:GetFirst()
	if not qc then return end
	Duel.SendtoHand(qc,tp,REASON_RULE)
end