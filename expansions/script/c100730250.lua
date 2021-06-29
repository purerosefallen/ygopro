--高速决斗技能-王者之威
Duel.LoadScript("speed_duel_common.lua")
function c100730250.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(61032879,c)
	aux.SpeedDuelAtMainPhase(c,c100730250.skill,c100730250.con,aux.Stringid(100730250,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730250.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730250.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730250.filter(c)
	return c:IsFaceup() and c:IsCode(70902743)
end
function c100730250.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,87614611,50215517,24566654)
	if g2:GetCount()==0 then return end
	local qc=g2:GetFirst()
	if not qc then return end
	Duel.SendtoHand(qc,tp,REASON_RULE)
end