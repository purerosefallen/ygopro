--高速决斗技能-奇迹抽卡
Duel.LoadScript("speed_duel_common.lua")
function c100730047.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730047.skill,c100730047.con,aux.Stringid(100730047,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730047.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x3008)
end

function c100730047.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(c100730047.filter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.GetTurnCount()>=3
end

function c100730047.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730047,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730047)
		local c=Duel.CreateToken(tp,55144522)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end