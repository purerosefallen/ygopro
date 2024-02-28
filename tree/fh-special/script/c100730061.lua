--高速决斗技能-扰乱怪泛滥
Duel.LoadScript("speed_duel_common.lua")
function c100730061.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730061.skill,c100730061.con,aux.Stringid(100730061,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730061.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(1-tp)>0
		and Duel.GetLP(tp)<=1000
end

function c100730061.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local m=3-Duel.GetFieldCount(1-tp,LOCATION_MZONE,0)
	local z=Duel.GetMZoneCount(1-tp)
	if m>z then m=z end
	while m>0 do
		Duel.Hint(HINT_CARD,1-tp,100730061)
		local token=Duel.CreateToken(tp,14470846)
		Duel.MoveToField(token,tp,1-tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
		m=m-1
	end
	e:Reset()
end