--高速决斗技能-盗贼
Duel.LoadScript("speed_duel_common.lua")
function c100730072.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730072.skill,c100730072.con,aux.Stringid(100730072,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730072.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetLP(tp)<=1500
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_SZONE,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c100730072.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730072)
	local tc=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_SZONE,1,1,nil):GetFirst()
	if tc:IsLocation(LOCATION_FZONE) then
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,tc:GetPosition(),true)
	else
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,tc:GetPosition(),true)
	end
	e:Reset()
end
