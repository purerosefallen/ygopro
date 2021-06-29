--高速决斗技能-奇迹融合时刻！
Duel.LoadScript("speed_duel_common.lua")
function c100730200.initial_effect(c)
	if not c100730200.UsedLP then
		c100730200.UsedLP={}
		c100730200.UsedLP[0]=0
		c100730200.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730200.skill,c100730200.con,aux.Stringid(100730200,1))   
	aux.SpeedDuelBeforeDraw(c,c100730200.skill2)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730200.skill2(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730200)
	local tc=Duel.CreateToken(tp,53586134)
	aux.SpeedDuelSendToHandWithExile(tp,tc)
	e:Reset()
end
function c100730200.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730200,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730200)
		c100730200.UsedLP[tp]=c100730200.UsedLP[tp]+1000
				Duel.Hint(HINT_CARD,1-tp,100730200)
		local c=Duel.CreateToken(tp,45906428)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		e:Reset()
	end
end

function c100730200.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.DecreasedLP[tp]-c100730200.UsedLP[tp] >= 1000
end