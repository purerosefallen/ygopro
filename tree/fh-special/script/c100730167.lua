--高速决斗技能-惊喜的赠礼
Duel.LoadScript("speed_duel_common.lua")
function c100730167.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730167.skill,c100730167.con,aux.Stringid(100730167,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730167.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_SZONE,0,1,nil)
		and Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0
end
function c100730167.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730167)
	local tc=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_SZONE,0,1,1,nil):GetFirst()
	if tc:IsLocation(LOCATION_FZONE) then
		Duel.MoveToField(tc,tp,1-tp,LOCATION_FZONE,tc:GetPosition(),true)
	else
		Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,tc:GetPosition(),true)
	end
	Duel.Draw(tp,1,REASON_RULE)
	e:Reset()
end
