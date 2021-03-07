--高速决斗技能-牲祭封印之假面
Duel.LoadScript("speed_duel_common.lua")
function c100730102.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730102.skill,c100730102.con,aux.Stringid(100730102,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730102.Ismask(c)
	return c:IsOriginalCodeRule(48948935) or c:IsOriginalCodeRule(49064413) and c:IsFaceup()
end

function c100730102.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730102.Ismask,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730102.skill(e,tp)
	local d=Duel.CreateToken(tp,29549364)
	Duel.MoveToField(d,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end