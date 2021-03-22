--高速决斗技能-我最讨厌危险的东西了呢
Duel.LoadScript("speed_duel_common.lua")
function c100730176.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730176.skill,c100730176.con,aux.Stringid(100730176,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730176.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
	and Duel.GetTurnPlayer()==tp 
	and Duel.IsExistingMatchingCard(c100730176.Isexist,tp,0,LOCATION_MZONE,1,nil)
end
function c100730176.Isexist(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:GetAttack()>=c:GetTextAttack()+1000 and c:GetEquipCount()>=1 and c:IsCanBeEffectTarget()
end
function c100730176.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730176,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730176)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c100730176.Isexist,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Exile(g,REASON_RULE)
		e:Reset()
	end
end