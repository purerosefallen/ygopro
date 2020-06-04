--高速决斗技能-上吧，扰乱怪！
Duel.LoadScript("speed_duel_common.lua")
function c100730060.initial_effect(c)
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730060.skill,c100730060.con,aux.Stringid(100730060,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730060.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(1-tp)>0
		and aux.DecreasedLP[tp]>=1800
end

function c100730060.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local token=Duel.CreateToken(tp,14470846)
	Duel.MoveToField(token,tp,1-tp,LOCATION_MZONE,POS_FACEUP_DEFENSE,true)
	e:Reset()
end