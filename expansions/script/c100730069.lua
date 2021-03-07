--高速决斗技能-融合变化（真红眼）
Duel.LoadScript("speed_duel_common.lua")
function c100730069.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730069.skill,c100730069.con,aux.Stringid(100730069,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730069.filter(c)
	return (c:IsType(TYPE_NORMAL) and c:IsLevel(6) and c:IsRace(RACE_FIEND))
		or (c:IsType(TYPE_NORMAL) and c:IsLevel(6) and c:IsRace(RACE_DRAGON))
		or (c:IsType(TYPE_NORMAL) and c:IsLevel(4) and c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_EARTH))
end
c100730069.filterfunction c100730069.mfilter(c)
	return c:GetOriginalCodeRule()==74677422
end
function c100730069.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730069.mfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100730069.filter,tp,LOCATION_HAND,0,1,nil)
end
function c100730069.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730069)
	local c=Duel.SelectMatchingCard(tp,c100730069.mfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	local pos=c:GetPosition()
	local seq=c:GetSequence()
	local tc=Duel.SelectMatchingCard(tp,c100730069.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	local code=90660762
	if tc:IsRace(RACE_FIEND) then code=11901678 end
	if tc:IsRace(RACE_WARRIOR) then code=21140872 end
	Duel.SendtoGrave(tc,REASON_RULE+REASON_DISCARD)
	Duel.Exile(c,REASON_RULE)
	local nc=Duel.CreateToken(tp,code)
	Duel.MoveToField(nc,tp,tp,LOCATION_MZONE,pos,true)
	Duel.MoveSequence(nc,seq)
end
