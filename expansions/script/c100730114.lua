--高速决斗技能-蝼蚁和魔鬼
Duel.LoadScript("speed_duel_common.lua")
function c100730114.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730114.skill,c100730114.con,aux.Stringid(100730114,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730114.Issun(c)
	return c:IsOriginalCodeRule(42280216) and c:IsFaceup()
end

function c100730114.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730114.Issun,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730114.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730114,0)) then
		local d=Duel.CreateToken(tp,78275321)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		else local d=Duel.CreateToken(tp,78552773)
		Duel.MoveToField(d,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	end
end