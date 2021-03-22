--高速决斗技能-奇迹融合时刻！
Duel.LoadScript("speed_duel_common.lua")
function c100730136.initial_effect(c)
	if not c100730136.UsedLP then
		c100730136.UsedLP={}
		c100730136.UsedLP[0]=0
		c100730136.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730136.skill,c100730136.con,aux.Stringid(100730136,1))	
	aux.SpeedDuelBeforeDraw(c,c100730136.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730136.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730136)
	local tc=Duel.CreateToken(tp,53586134)
	aux.SpeedDuelSendToHandWithExile(tp,tc)
	e:Reset()
end
function c100730136.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730136,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730136)
		c100730136.UsedLP[tp]=c100730136.UsedLP[tp]+1000
				Duel.Hint(HINT_CARD,1-tp,100730136)
		local c=Duel.CreateToken(tp,45906428)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end

function c100730136.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.DecreasedLP[tp]-c100730136.UsedLP[tp] >= 1000
end