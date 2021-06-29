--高速决斗技能-神秘礼物
Duel.LoadScript("speed_duel_common.lua")
function c100730029.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730029.skill,c100730029.con,aux.Stringid(100730029,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730029.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730029.filter,tp,LOCATION_SZONE,0,1,nil)
		and Duel.GetLocationCount(1-tp,LOCATION_SZONE)>0
end
function c100730029.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730029)
	local tc=Duel.SelectMatchingCard(tp,c100730029.filter,tp,LOCATION_SZONE,0,1,1,nil):GetFirst()
	if tc:IsLocation(LOCATION_FZONE) then
		Duel.MoveToField(tc,tp,1-tp,LOCATION_FZONE,tc:GetPosition(),true)
	else
		Duel.MoveToField(tc,tp,1-tp,LOCATION_SZONE,tc:GetPosition(),true)
	end
	local d=Duel.CreateToken(1-tp,56119752)
	Duel.SendtoHand(d,tp,REASON_RULE)
	e:Reset()
end

function c100730029.filter(c)
	return c:IsFacedown()
end